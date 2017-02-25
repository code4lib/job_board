$(function() {
  var tags = new Bloodhound({
    datumTokenizer: function(d) { return Bloodhound.tokenizers.whitespace(d.name); },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    limit: 100,
    prefetch: {
      url: '/tags.json',
      ttl: 1,
      filter: function(list) {
        return list;
      }
    }
  });

  tags.initialize();
  $(document).on('turbolinks:load', function() {
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
