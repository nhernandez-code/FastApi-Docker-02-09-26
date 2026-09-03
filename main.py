from fastapi import FastAPI
from pydantic import BaseModel
import random

app = FastAPI()


@app.get("/obtenercedula")
def obtener_cedula():
    """Devuelve un entero aleatorio de 10 dígitos."""
    return random.randint(10**9, 10**10 - 1)


def int_to_roman(num: int) -> str:
    """Convierte un entero positivo a número romano (soporta hasta varios miles)."""
    val = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
    syms = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
    roman_num = []
    i = 0
    while num > 0:
        count = num // val[i]
        roman_num.append(syms[i] * count)
        num -= val[i] * count
        i += 1
    return "".join(roman_num)


@app.get("/obtenerromano")
def obtener_romano():
    """Devuelve aleatoriamente un número romano entre 50 y 100 (inclusive)."""
    n = random.randint(50, 100)
    return int_to_roman(n)


class NumeroRequest(BaseModel):
    numero: int


@app.post("/multiplicar")
def multiplicar(payload: NumeroRequest):
    """Recibe JSON con `numero` y devuelve { "resultado": numero * 2 }."""
    return {"resultado": payload.numero * 2}


if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
