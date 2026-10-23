// Fixture de teste: código com problemas de propósito. Não use em produção.
import OpenAI from "openai";
export const reply = (msg) => new OpenAI().chat.completions.create({ model: "x", messages: [{ role: "user", content: msg }] });
