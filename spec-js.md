# Specifications for the Rails with jQuery Assessment

Specs:
- [x] Use jQuery for implementing new requirements
- [x] Include a show resource rendered using jQuery and an Active Model Serialization JSON backend.

Implemented AJAX show Lesson and show Comment with Active Model Serializer.  

- [x] Include an index resource rendered using jQuery and an Active Model Serialization JSON backend.

Implemented index Comments, index Lessons, index Requests with Active Model Serializer.

- [x] Include at least one has_many relationship in information rendered via JSON and appended to the DOM.

Each lesson has many comments. Implemented next and previous lesson AJAX functionality. In each lesson users can update and destroy comments. Users also can update several comments simultaneously.

- [x] Include at least one link that loads or updates a resource without reloading the page.

Implemented AJAX update comment, AJAX accept/decline request (to add as a student).
Implemented AJAX loading of all user's lessons by categories on click event.

- [x] Translate JSON responses into js model objects.

All JS logic is implemented mostly in object-oriented style. The code contains Comment, Lesson, Request models.

- [x] At least one of the js model objects must have at least one method added by your code to the prototype.

For example, all Handlebars template functions and rendering functions are embedded in Comment, Lesson, Request models prototypes.

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
