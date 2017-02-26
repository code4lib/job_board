$(function() {
  var tags = new Bloodhound({
    initialize: false,
    datumTokenizer: function(d) { return Bloodhound.tokenizers.whitespace(d.name); },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: {
      url: '/tags.json',
      ttl: 3000,
      filter: function(list) {
        return list;
      }
    }
  });

  $(document).on('turbolinks:load', function() {
    if($('#job_tag_list').length > 0) {
      tags.initialize();
    }

    $('#job_tag_list').tagsinput({
      freeInput: true,
      typeaheadjs: {
        name: 'tags',
        displayKey: 'name',
        valueKey: 'name',
        source: tags.ttAdapter()
      }
    });
  });

});
