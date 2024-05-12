from functools import wraps

from flask import g, jsonify, request

from repository import user as user_repository


def auth(f):
    @wraps(f)
    def auth_function(*args, **kwargs):
        try:
            user_id = request.headers.get("Authorization")

            if user_id is None:
                raise KeyError("No auth provided")

            user = user_repository.get_user_by_id(user_id)

            if user is None or user.role not in ["user", "admin"]:
                raise KeyError("User not authorized")

            g.user = user
            return f(*args, **kwargs)

        except Exception as err:
            return jsonify({"message": f"{err}"}), 401

    return auth_function


def admin_auth(f):
    @wraps(f)
    def admin_auth_function(*args, **kwargs):
        try:
            user_id = request.headers.get("Authorization")

            if user_id is None:
                raise KeyError("No auth provided")

            user = user_repository.get_user_by_id(user_id)

            if user is None or user.role not in ["admin"]:
                raise KeyError("User not authorized")

            g.user = user
            return f(*args, **kwargs)

        except Exception as err:
            return jsonify({"message": f"{err}"}), 401

    return admin_auth_function
