
jQuery(function($){
    $('.mt-table > tbody').paginathing({//親要素のclassを記述
		perPage: 30,//1ページあたりの表示件数
		activeClass: 'navi-active',//現在のページ番号に任意のclassを付与できます
	});
});