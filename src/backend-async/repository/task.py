from typing import Sequence

from sqlalchemy import select
from sqlalchemy.orm import sessionmaker

from database.engine import engine
from database.models import Task


def get_all(user_id: str) -> Sequence[Task]:
    Session = sessionmaker(bind=engine)
    session = Session()

    result = session.execute(select(Task).filter_by(user_id=user_id))
    tasks = result.scalars().all()
    session.close()

    return tasks


def create_task(user_id: str, task: str):
    task = Task(text=task, status="pending", user_id=user_id)

    Session = sessionmaker(bind=engine)
    session = Session()

    session.add(task)
    session.commit()
    session.close()


def update_task(user_id: str, task_id: str, status: str) -> Task | None:
    Session = sessionmaker(bind=engine)
    session = Session()
    try:

        result = session.execute(select(Task).filter_by(id=task_id, user_id=user_id))

        task = result.scalars().first()

        if task is None:
            raise RuntimeError("Task not found")

        task.status = status

        session.commit()

        return task

    except Exception as _:
        return None

    finally:
        session.close()


def get_task(user_id: str, task_id: str) -> Task | None:
    Session = sessionmaker(bind=engine)
    session = Session()
    try:

        result = session.execute(select(Task).filter_by(id=task_id, user_id=user_id))

        task = result.scalars().first()

        if task is None:
            raise RuntimeError("Task not found")

        return task

    except Exception as _:
        return None

    finally:
        session.close()


def delete_task(user_id: str, task_id: str) -> Task | None:
    Session = sessionmaker(bind=engine)
    session = Session()

    task = get_task(user_id, task_id)

    if task is None:
        return None

    session.delete(task)
    session.commit()
    session.close()

    return task
