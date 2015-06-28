SwapPanesView = require './swap-panes-view'
{CompositeDisposable} = require 'atom'

module.exports = SwapPanes =
  swapPanesView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @swapPanesView = new SwapPanesView(state.swapPanesViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @swapPanesView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'swap-panes:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @swapPanesView.destroy()

  serialize: ->
    swapPanesViewState: @swapPanesView.serialize()

  toggle: ->
    console.log 'SwapPanes was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
