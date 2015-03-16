# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	choose_true = '<div class="bold">確定済み ヽ( ´￢`)ノ ﾜ～ｲ !!</div><button type="button" class="btn btn-sm btn-warning cancel">確定を取り消し</button>'
	choose_false = '<button type="button" class="btn btn-sm btn-danger choose">確定</button>'

	$('.choose').on 'click', ->
		pictureId = $(@).next().val()
		choose pictureId, (res) =>
			if res.success
				$(@).parent().append(choose_true).on 'click', ->
					alert('もう一度キャンセルするにはリロードしてください')
				$(@).remove()
			else
				alert('エラーが発生しました。ログとか見てみてください')

	$('.cancel').on 'click', ->
		pictureId = $(@).next().val()
		choose pictureId, (res) =>
			if res.success
				$(@).parent().append(choose_false).on 'click', ->
					alert 'もう一度、確定するにはリロードしてください'
				$(@).prev().remove()
				$(@).remove()
			else
				alert('エラーが発生しました。ログとか見てみてください')

	choose = (pictureId, callback) ->
		$.post "../pictures/#{pictureId}/choose", (res) ->
			callback(res)
