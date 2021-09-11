## Background & Objectives

Create a cool profile dashboard by inserting your infos into a nice 2D layout. You'll
have to use a lot of CSS positionning techniques.

## Specs

Here is [the objective](https://lewagon.github.io/html-css-challenges/06-profile-dashboard/). Before inserting your different profile informations into the layout, start by building this layout step-by-step :

- Create and center the main container.
- Add two floating `<div>` into this container. In order to get the main container wrap these two div, you'll have to use a third div with `clear: both;` CSS property after the two floating ones (this is a classic CSS trick).


```html
<div id="container">
  <div id="left"></div>
  <div id="right"></div>
  <div class="clear"></div>
  <div id="footer">
    <ul class="list-inline"></ul>
  </div>
</div>
```

- Finally, add the bottom footer division. Notice the absolute position of the icon list at bottom-right of this footer div. You will have to use a `relative > absolute` CSS pattern to obtain such result.
