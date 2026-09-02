from fastapi import FastAPI
import random

app = FastAPI()


@app.get("/obtenercedula")
def obtener_cedula():
    """Devuelve un entero aleatorio de 10 dígitos."""
    return random.randint(10**9, 10**10 - 1)


if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
