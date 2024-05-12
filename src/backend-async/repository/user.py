from flask import session
from sqlalchemy import select
from sqlalchemy.orm import sessionmaker

from database.engine import engine
from database.models import User


def get_user_by_id(id: str) -> User | None:
    Session = sessionmaker(bind=engine)
    session = Session()

    result = session.execute(select(User).filter_by(id=id))

    user = result.scalars().first()

    session.close()

    return user

def create_user(user_name: str, user_role: str):
    user = User(name=user_name, role=user_role)

    Session = sessionmaker(bind=engine)
    session = Session() 

    session.add(user)
    session.commit()
    session.close()

    

