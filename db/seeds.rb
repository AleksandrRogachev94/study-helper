stan = User.create(email: "Stan@gmail.com", password: "12345678", password_confirmation: "12345678")
roger = User.create(email: "Roger@gmail.com", password: "12345678", password_confirmation: "12345678")

math = Category.create(title: "Math")
phys = Category.create(title: "Physics")
eng = Category.create(title: "English")
his = Category.create(title: "History")

stan.lessons.create(title: "Boolean logic", content: "true && false = false", category: math)
stan.lessons.create(title: "Logarithms", content: "ln(0) = 1", category: math)
stan.lessons.create(title: "Trigonometry (sin^2(x) + cos^2(x) = 1)", category: math)
stan.lessons.create(title: "Kinematics", content: "S = V*t", category: phys)
stan.lessons.create(title: "Electricity", content: "I = U/R", category: phys)
stan.lessons.create(title: "Optics", content: "div B = 0", category: phys)

roger.lessons.create(title: "1-st half of 19-th century", category: his, content: "History stuff")
roger.lessons.create(title: "2-nd half of 19-th century", category: his, content: "History stuff")
roger.lessons.create(title: "Present Simple", category: eng, content: "he, she, it => 's' ending")
roger.lessons.create(title: "Future Simple", category: eng, content: "I WILL make it")
