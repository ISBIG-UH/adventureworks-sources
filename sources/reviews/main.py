from typing import List, Optional, Dict, Any
from fastapi import FastAPI, HTTPException, Query
from data_service import DataService
from pydantic import BaseModel
from datetime import datetime


class Store(BaseModel):
    id: int
    name: str

class User(BaseModel):
    id: int
    firstName: str
    lastName: str
    email: str
    birthdate: str

class Review(BaseModel):
    id: int
    userid: int
    storeid: int
    product: str
    rating: int
    date: str




ds = DataService("reviews.duckdb")
app = FastAPI()

# -----------------------
# Endpoints
# -----------------------
@app.get("/stores", response_model=List[Store])
def get_stores(page: int = Query(0, ge=0), size: int = Query(20, ge=1)):
    """
    Paginated list of stores.
    """
    df = ds.get_stores(size, page)
    return  df.to_dict(orient="records")

@app.get("/users", response_model=List[User])
def get_users(page: int = Query(0, ge=0), size: int = Query(20, ge=1)):
    """
    Paginated list of users.
    """
    df = ds.get_users(size, page)
    return df.to_dict(orient="records")

@app.get("/reviews", response_model=List[Review])
def get_reviews(
    store: Optional[int] = Query(None, description="Filter by store id"),
    user: Optional[int] = Query(None, description="Filter by user id"),
    page: int = Query(0, ge=0),
    size: int = Query(20, ge=1)
):
    """
    Paginated list of reviews.
    """
    df = ds.get_reviews(size, page, store=store, user=user)
    return df.to_dict(orient="records")
