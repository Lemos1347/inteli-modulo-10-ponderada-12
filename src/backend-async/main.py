from dotenv import load_dotenv

load_dotenv()

from flask import Flask, g, jsonify, request
from flask_swagger_ui import get_swaggerui_blueprint
from middleware import admin_auth, auth
from repository import task as task_repository
from repository import user as user_repository

app = Flask(__name__)
# Configuração do Swagger UI
SWAGGER_URL = "/docs"
API_URL = "/static/swagger.yml"
SWAGGER_BLUEPRINT = get_swaggerui_blueprint(
    SWAGGER_URL,
    API_URL,
    config={"app_name": "To-do API"},
)

app.register_blueprint(SWAGGER_BLUEPRINT, url_prefix=SWAGGER_URL)


@app.post("/create_user")
@admin_auth
def create_user_route():
    if request.is_json:
        data = request.get_json()

        user_name = data.get("user_name")
        user_role = data.get("user_role")

        if (
            user_name is None
            or type(user_name) != str
            or user_role not in ["admin", "user"]
        ):
            return jsonify(message="Uncompleted body"), 400

        user_repository.create_user(user_name=user_name, user_role=user_role)

        return jsonify(message="User created with success!"), 201
    else:
        return jsonify(message="The request body must be a json"), 400


@app.post("/create_task")
@auth
def create_task_route():
    if request.is_json:
        user = getattr(g, "user", None)

        if user is None:
            return jsonify(message="Auth didn't provided an user"), 404

        data = request.get_json()

        to_do_task = data.get("task")

        if to_do_task is None or type(to_do_task) != str:
            return jsonify(message="No user_name provided"), 400

        task_repository.create_task(user_id=user.id, task=to_do_task)

        return jsonify(message="Task created with success"), 201

    else:
        return jsonify(message="The request body must be a json"), 400


@app.get("/tasks")
@auth
def get_all_tasks_routes():
    user = getattr(g, "user", None)

    if user is None:
        return jsonify(message="Auth didn't provided user"), 404

    tasks = task_repository.get_all(user.id)

    return (
        jsonify(
            tasks=[
                {"id": task.id, "text": task.text, "status": task.status}
                for task in tasks
            ]
        ),
        200,
    )


@app.put("/update_task")
@auth
def update_task_route():
    if request.is_json:
        user = getattr(g, "user", None)

        if user is None:
            return jsonify(message="Auth didn't provided user"), 404

        data = request.get_json()

        task_id = data.get("task_id")
        new_task_status = data.get("status")

        if new_task_status not in ["pending", "done"] or task_id is None:
            return jsonify(message="Uncompleted body"), 400

        task = task_repository.update_task(user.id, task_id, new_task_status)

        if task is None:
            return jsonify(message="Unable to update task"), 500

        return jsonify(message="Task modified with success"), 202

    else:
        return jsonify(message="The request body must be a json"), 400


@app.delete("/delete_task")
@auth
def delete_task_route():
    if request.is_json:
        user = getattr(g, "user", None)

        if user is None:
            return jsonify(message="Auth didn't provided an user"), 404

        data = request.get_json()

        task_id = data.get("task_id")

        if task_id is None:
            return jsonify(message="Uncompleted body"), 400

        task = task_repository.delete_task(user.id, task_id)

        if task is None:
            return jsonify(message="Task doesn't exists"), 500

        return jsonify(message="Task deleted with success"), 203

    else:
        return jsonify(message="The request body must be a json"), 400


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3001)
