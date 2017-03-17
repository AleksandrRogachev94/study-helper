# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project

- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes) 

User has many lessons, Category has many Lessons, User has many Requests, User has many Studyships.

- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)

Lesson belongs to User, Lesson belongs to Category, Request belongs to User, Studyship belongs to User

- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients)

User has many Categories through lessons, User has many Teachers through Studyships, User has many Students through Studyships

- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)

Lesson belongs_to Category and User, includes title, description, content, and links.

- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)

All appropriate validations are made. For example, uniqueness of Category title (case insensitive), presence of first name and last name in Profile...

- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)

For example, implemented Studyship.most_popular_teachers(with the corresponging URL), Category.search, User.search, User.from_omniauth, Studyship.establish_mutual_relationships.

- [x] Include a nested form writing to an associated model using a custom attribute writer (form URL, model name e.g. /recipe/new, Item)

User can create category when creating lesson.

- [x] Include signup (how e.g. Devise)

Devise is used.

- [x] Include login (how e.g. Devise)

Devise is used.

- [x] Include logout (how e.g. Devise)

Devise is used.

- [x] Include third party signup/login (how e.g. Devise/OmniAuth)

Devise is used.

Also Pundit is used for authorization purposes.

- [x] Include nested resource show or index (URL e.g. users/2/recipes)

Inside of User the following resources are nested: Lessons, Profile, Studyships.

- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)

Both Lesson and Studyship can be created in context of User (nested resources).

- [x] Include form display of validation errors (form URL e.g. /recipes/new).

Done for all forms.

Confirm:
- [x] The application is pretty DRY

Partials, Helpers, Methods are used.

- [x] Limited logic in controllers

Business logic is located in models.

- [x] Views use helper methods if appropriate

Done.

- [x] Views use partials if appropriate

Done.

