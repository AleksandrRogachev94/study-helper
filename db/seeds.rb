stan = User.create(email: "Stan@gmail.com", password: "12345678", password_confirmation: "12345678")
roger = User.create(email: "Roger@gmail.com", password: "12345678", password_confirmation: "12345678")
nick = User.create(email: "Nick@gmail.com", password: "12345678", password_confirmation: "12345678")
helen = User.create(email: "Helen@gmail.com", password: "12345678", password_confirmation: "12345678")
linda = User.create(email: "Linda@gmail.com", password: "12345678", password_confirmation: "12345678")
pablo = User.create(email: "Pablo@gmail.com", password: "12345678", password_confirmation: "12345678")



math = Category.create(title: "Math")
phys = Category.create(title: "Physics")
eng = Category.create(title: "English")
his = Category.create(title: "History")
biol = Category.create(title: "Biology")
chem = Category.create(title: "Chemistry")
fren = Category.create(title: "French")
span = Category.create(title: "Spanish")
astr = Category.create(title: "Astronomy")
econ = Category.create(title: "Economics")

stan.lessons.create(title: "Boolean logic", content: "true && false = false", category: math)
stan.lessons.create(title: "Logarithms", content: "ln(0) = 1", category: math)
stan.lessons.create(title: "Trigonometry", content:"(sin^2(x) + cos^2(x) = 1)", category: math)
stan.lessons.create(title: "Kinematics", content: "S = V*t", category: phys)
stan.lessons.create(title: "Electricity", content: "I = U/R", category: phys)
stan.lessons.create(title: "Optics", content: "div B = 0", category: phys)

roger.lessons.create(title: "1-st half of 19-th century", category: his, content: "History stuff")
roger.lessons.create(title: "2-nd half of 19-th century", category: his, content: "History stuff")
roger.lessons.create(title: "Present Simple", category: eng, content: "he, she, it => 's' ending")
roger.lessons.create(title: "Future Simple", category: eng, content: "I WILL make it")

nick.lessons.create(title: "Mushrooms", content: "A mushroom (or toadstool) is the fleshy, spore-bearing fruiting body of a fungus, typically produced above ground on soil or on its food source.", category: biol)
nick.lessons.create(title: "Mosses", content: "Mosses are small flowerless plants that typically grow in dense green clumps or mats, often in damp or shady locations.", category: biol)

helen.lessons.create(title: "Les Articles", content: "Il y a trois types des articles en Français: défini, indéfini et partitif", category: fren)
helen.lessons.create(title: "Les Articles Défini", content: "Ils sont le, la et les.", category: fren)

pablo.lessons.create(title: "España", content: "El país está situado al Suroeste de Europa.", category: span)
pablo.lessons.create(title: "Mi familia", content: "Mi nombre es Natalia, Natasha en corto. Tengo una gran familia.", category: span)
