import Backbone from 'backbone'

import NavbarEntry from './entry-model'

NavbarChannel = Backbone.Radio.channel 'navbar'

class NavbarEntryCollection extends Backbone.Collection
  model: NavbarEntry


siteEntryCollection = new NavbarEntryCollection
userEntryCollection = new NavbarEntryCollection
appletEntryCollection = new NavbarEntryCollection
viewEntryCollection = new NavbarEntryCollection

collections =
  site: siteEntryCollection
  user: userEntryCollection
  applet: appletEntryCollection
  view: viewEntryCollection
  
NavbarChannel.reply 'get-entries', (collection) ->
  return collections[collection]

  
NavbarChannel.reply 'new-navbar-entry', ->
  new NavbarEntry

NavbarChannel.reply 'add-entry', (atts, collection) ->
  collections[collection].add atts

NavbarChannel.reply 'add-entries', (olist, collection) ->
  collections[collection].add olist

NavbarChannel.reply 'clear-entries', (collection) ->
  collections[collection].reset()
  
