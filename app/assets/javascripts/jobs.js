$(function() {
  var employers = new Bloodhound({
    datumTokenizer: function(d) { return Bloodhound.tokenizers.whitespace(d.name); },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    // limit: 100,
    prefetch: {
      url: '/employers.json',
      ttl: 1,
      filter: function(list) {
        return list;
      }
    }
  });

  employers.initialize();
  $(document).on('turbolinks:load', function() {
    $('#job_employer_name').typeahead({
        highlight: true,
        minLength: 0
      }, {
      name: 'employer_name',
      display: 'name',
      source: employers.ttAdapter()
    });
    $('#job_employer_name').closest('.twitter-typeahead').css('display', 'inline');
  });

});
