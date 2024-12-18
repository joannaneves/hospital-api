const express = require("express")
const cors = require("cors")
const Stripe = require("stripe")

const app = express()
const stripe = new Stripe(
  "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"
)

app.use(
  cors({
    origin: "http://localhost:8080", // Permitir apenas requisições do frontend
  })
)
app.use(express.json())

// Simulando um banco de dados para pacientes e receitas
let patients = []
let recipes = [] // Array para armazenar receitas

// Endpoint para criar o Payment Intent no Stripe
app.post("/create-payment-intent", async (req, res) => {
  try {
    const { amount, currency } = req.body

    // Verificar se o valor foi enviado corretamente
    if (!amount || amount <= 0) {
      return res.status(400).send({ error: "Valor inválido" })
    }

    const paymentIntent = await stripe.paymentIntents.create({
      amount: amount * 100, // Conversão para centavos
      currency: currency || "brl", // Padrão para BRL
    })

    res.status(200).send({
      clientSecret: paymentIntent.client_secret,
    })
  } catch (error) {
    console.error("Erro ao criar o Payment Intent:", error)
    res.status(500).send({ error: "Erro ao criar o pagamento" })
  }
})

// Endpoint para adicionar uma receita a um paciente
app.post("/patients/:id/recipe", (req, res) => {
  const { id } = req.params
  const { recipe } = req.body

  // Verifica se o paciente existe
  const patient = patients.find((p) => p.id === id)
  if (!patient) {
    return res.status(404).send({ error: "Paciente não encontrado" })
  }

  // Salva a receita
  const patientRecipe = { patientId: id, recipe }
  recipes.push(patientRecipe)

  res.status(200).send({ message: "Receita adicionada com sucesso!" })
})

// Endpoint para recuperar receitas de um paciente
app.get("/patients/:id/recipe", (req, res) => {
  const { id } = req.params

  const patientRecipes = recipes.filter((r) => r.patientId === id)

  if (patientRecipes.length === 0) {
    return res
      .status(404)
      .send({ error: "Nenhuma receita encontrada para este paciente" })
  }

  res.status(200).send(patientRecipes)
})

// Iniciar o servidor na porta 3000
app.listen(3000, () => {
  console.log("Servidor rodando na porta 3000")
})
