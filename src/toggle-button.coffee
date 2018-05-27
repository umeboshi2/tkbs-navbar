import $ from 'jquery'
import Backbone from 'backbone'
import Marionette from 'backbone.marionette'
import tc from 'teacup'

class NavbarToggleButton extends Marionette.View
  tagName: 'button'
  className: 'navbar-toggler pull-right'
  attributes:
    type: 'button'
    'data-toggle': 'collapse'
    'data-target': '#navbar-view-collapse'
    'aria-controls': 'navbar-view-collapse'
    'aria-expanded': 'false'
    'aria-label': 'Toggle navigation'
  template: tc.renderable ->
    tc.span '.navbar-toggler-icon'
    
export default NavbarToggleButton


