$(function() {
  var employers = new Bloodhound({
    initialize: false,
    datumTokenizer: function(d) { return Bloodhound.tokenizers.whitespace(d.name); },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: {
      url: '/employers.json',
      ttl: 1,
      filter: function(list) {
        return list;
      }
    }
  });

  $(document).on('turbolinks:load', function() {
    if($('#job_description').length > 0) {
      if (typeof CKEDITOR != 'undefined') {
        if (CKEDITOR.instances['job_description']) { CKEDITOR.instances['job_description'].destroy(); }
        CKEDITOR.replace('job_description');
      }
    }

    $('.publish[data-remote]').on('ajax:success', function() {
      $(this).closest('tr').remove();
    });

    if($('#job_employer_name').length > 0) {
      employers.initialize();
    }

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
