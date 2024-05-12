import uuid

from sqlalchemy import UUID, Enum, ForeignKey, String, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship

from database.base_model import Base


class User(Base):
    __tablename__ = "User"
    id: Mapped[str] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    name: Mapped[str] = mapped_column(String, nullable=False)
    role: Mapped[Enum] = mapped_column(Enum("user", "admin", name="user_role"))

    # Relationships
    tasks: Mapped[list["Task"]] = relationship(back_populates="user")


class Task(Base):
    __tablename__ = "Task"
    id: Mapped[str] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    text: Mapped[str] = mapped_column(Text, nullable=False)
    status: Mapped[Enum] = mapped_column(Enum("pending", "done", name="task_status"))
    user_id: Mapped[str] = mapped_column(
        UUID(as_uuid=True), ForeignKey("User.id"), nullable=False
    )

    # Relationships
    user: Mapped["User"] = relationship(back_populates="tasks")
