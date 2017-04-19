profile = Profile.create(first_name: "Stan", last_name: "Smith (Example)", interests: "Physics and Math")
stan = User.create(email: "stan@gmail.com", password: "12345678", password_confirmation: "12345678", profile: profile)
profile = Profile.create(first_name: "Roger", last_name: "Federer (Example)", interests: "History")
roger = User.create(email: "roger@gmail.com", password: "12345678", password_confirmation: "12345678", profile: profile)
profile = Profile.create(first_name: "Nick", last_name: "Johnson (Example)", interests: "Biology")
nick = User.create(email: "nick@gmail.com", password: "12345678", password_confirmation: "12345678", profile: profile)
profile = Profile.create(first_name: "Helen", last_name: "Williams (Example)", interests: "French")
helen = User.create(email: "helen@gmail.com", password: "12345678", password_confirmation: "12345678", profile: profile)
profile = Profile.create(first_name: "Linda", last_name: "Jones (Example)")
linda = User.create(email: "linda@gmail.com", password: "12345678", password_confirmation: "12345678", profile: profile)
profile = Profile.create(first_name: "Pablo", last_name: "Garcia (Example)", interests: "Spanish")
pablo = User.create(email: "pablo@gmail.com", password: "12345678", password_confirmation: "12345678", profile: profile)

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

stan.lessons.create(title: "Boolean logic", category: math,
                    description: "Basics of Boolean Algebra",
                    content: <<-HEREDOC,
In mathematics and mathematical logic, Boolean algebra is the branch of algebra in which the values of the variables are the truth values true and false, usually denoted 1 and 0 respectively. Instead of elementary algebra where the values of the variables are numbers, and the main operations are addition and multiplication, the main operations of Boolean algebra are the conjunction and denoted as ∧, the disjunction or denoted as ∨, and the negation not denoted as ¬. It is thus a formalism for describing logical relations in the same way that ordinary algebra describes numeric relations.

Boolean algebra was introduced by George Boole in his first book The Mathematical Analysis of Logic (1847), and set forth more fully in his An Investigation of the Laws of Thought (1854). According to Huntington, the term "Boolean algebra" was first suggested by Sheffer in 1913.

Boolean algebra has been fundamental in the development of digital electronics, and is provided for in all modern programming languages. It is also used in set theory and statistics.
                    HEREDOC
                    links: "https://en.wikipedia.org/wiki/Boolean_algebra"
                    )
stan.lessons.create(title: "Logarithms", category: math,
                    content: "ln(0) = 1................"
                    )
stan.lessons.create(title: "Trigonometry", category: math,
                    content:"(sin^2(x) + cos^2(x) = 1)............."
                    )
stan.lessons.create(title: "Kinematics", category: phys,
                    description: "Review of basic concepts of Kinematics",
                    content: <<-HEREDOC,
Kinematics is the branch of classical mechanics which describes the motion of points (alternatively "particles"), bodies (objects), and systems of bodies without consideration of the masses of those objects nor the forces that may have caused the motion.[1][2][3] Kinematics as a field of study is often referred to as the "geometry of motion" and as such may be seen as a branch of mathematics.[4][5][6] Kinematics begins with a description of the geometry of the system and the initial conditions of known values of the position, velocity and or acceleration of various points that are a part of the system, then from geometrical arguments it can determine the position, the velocity and the acceleration of any part of the system. The study of the influence of forces acting on masses falls within the purview of kinetics. For further details, see analytical dynamics.

Kinematics is used in astrophysics to describe the motion of celestial bodies and collections of such bodies. In mechanical engineering, robotics, and biomechanics[7] kinematics is used to describe the motion of systems composed of joined parts (multi-link systems) such as an engine, a robotic arm or the human skeleton.

The use of geometric transformations, also called rigid transformations, to describe the movement of components of a mechanical system simplifies the derivation of its equations of motion, and is central to dynamic analysis.

Kinematic analysis is the process of measuring the kinematic quantities used to describe motion. In engineering, for instance, kinematic analysis may be used to find the range of movement for a given mechanism, and working in reverse, using kinematic synthesis to design a mechanism for a desired range of motion.[8] In addition, kinematics applies algebraic geometry to the study of the mechanical advantage of a mechanical system or mechanism.
                    HEREDOC
                    links: "https://en.wikipedia.org/wiki/Kinematics"
                    )
stan.lessons.create(title: "Electricity", category: phys,
                    content: "I = U/R..............."
                    )
stan.lessons.create(title: "Optics", category: phys,
                    content: "div B = 0............."
                    )

roger.lessons.create(title: "1-st half of 19-th century", category: his,
                    content: "History stuff..............."
                    )
roger.lessons.create(title: "2-nd half of 19-th century", category: his,
                    content: "History stuff..............."
                    )
roger.lessons.create(title: "Present Simple", category: eng,
                    content: "he, she, it => 's' ending............."
                    )
roger.lessons.create(title: "Future Simple", category: eng,
                    content: "I WILL make it............."
                    )

nick.lessons.create(title: "Mushrooms", category: biol,
                    description: "This article is about fungi. For use in food, see Edible mushroom. For other uses, see Mushroom (disambiguation).",
                    content: <<-HEREDOC,
A mushroom (or toadstool) is the fleshy, spore-bearing fruiting body of a fungus, typically produced above ground on soil or on its food source.

The standard for the name "mushroom" is the cultivated white button mushroom, Agaricus bisporus; hence the word "mushroom" is most often applied to those fungi (Basidiomycota, Agaricomycetes) that have a stem (stipe), a cap (pileus), and gills (lamellae, sing. lamella) on the underside of the cap. These gills produce microscopic spores that help the fungus spread across the ground or its occupant surface.

"Mushroom" describes a variety of gilled fungi, with or without stems, and the term is used even more generally, to describe both the fleshy fruiting bodies of some Ascomycota and the woody or leathery fruiting bodies of some Basidiomycota, depending upon the context of the word.

Forms deviating from the standard morphology usually have more specific names, such as "bolete", "puffball", "stinkhorn", and "morel", and gilled mushrooms themselves are often called "agarics" in reference to their similarity to Agaricus or their order Agaricales. By extension, the term "mushroom" can also designate the entire fungus when in culture; the thallus (called a mycelium) of species forming the fruiting bodies called mushrooms; or the species itself.
                    HEREDOC
                    links: "https://en.wikipedia.org/wiki/Mushroom"
                    )
nick.lessons.create(title: "Mosses", category: biol,
                    content: "Mosses are small flowerless plants that typically grow in dense green clumps or mats, often in damp or shady locations."
                    )

helen.lessons.create(title: "Les Articles", category: fren,
                    content: "Il y a trois types des articles en Français: défini, indéfini et partitif"
                    )
helen.lessons.create(title: "Les Articles Défini", category: fren,
                    content: "Ils sont le, la et les."
                    )

pablo.lessons.create(title: "España", category: span,
                    content: "El país está situado al Suroeste de Europa."
                    )
pablo.lessons.create(title: "Mi familia", category: span,
                    content: "Mi nombre es Natalia, Natasha en corto. Tengo una gran familia."
                    )

Studyship.create(teacher: stan, student: pablo)
Studyship.create(teacher: stan, student: nick)
Studyship.create(teacher: nick, student: roger)
Studyship.create(teacher: nick, student: linda)
Studyship.create(teacher: helen, student: stan)
