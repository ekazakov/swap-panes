LabelView = require './label-view'
{CompositeDisposable} = require 'atom'

LABELS = ['A', 'S', 'D', 'F', 'J', 'K', ';', 'W', 'E', 'I', 'O']

module.exports = SwapPanes =
  swapPanesView: null
  modalPanel: null
  subscriptions: null
  isActive: false

  activate: (state) ->
    @swapPanesView = new SwapPanesView()

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add('atom-workspace', 'swap-panes:toggle': => @toggle())
    @subscriptions.add atom.commands.add('atom-workspace', 'keydown': (event) => @log(event))

  deactivate: ->
    # @modalPanel.destroy()
    @subscriptions.dispose()
    @swapPanesView.destroy()

  log: (event) ->
    if @isActive
        event.stopImmediatePropagation()
        event.preventDefault()
        @paneElement.removeChild @swapPanesView.getElement()
        console.log(event)
        @isActive = false


  toggle: ->
    panes = atom.workspace.getPanes();
    panesViews = panes.map (pane) -> atom.views.getView(pane)

    panesViews

    # views = (new LabelView(label) for label in LABELS.slice(0, panesViews.length))


#   pane = atom.workspace.getActivePane()
    #   @paneElement = atom.views.getView(pane)

    #   if not @isActive
    #     @paneElement.appendChild @swapPanesView.getElement()
    #     @isActive = true
    #   else
    #     @isActive = false
    #     @paneElement.removeChild @swapPanesView.getElement()
