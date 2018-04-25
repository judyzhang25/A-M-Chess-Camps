$(document).on('ready', function() {
  function run_ajax(method, data, link, callback=function(res){camp_instructors.get_camp_instructors()}){
    $.ajax({
      method: method,
      data: data,
      url: link,
      success: function(res) {
        callback(res);
      },
      error: function(res) {
        console.log("error");
        // Will update with an error handling function later
      }
    })
  }
  
   Vue.component('camp-instructor-row', {
    // Defining where to look for the HTML template in the index view
    template: '#camp-instructor-row',

    // Passed elements to the component from the Vue instance
    props: {
      camp_instructor: Object,
    },
    // Behaviors associated with this component
    methods: {
      remove_record: function(camp_instructor){
      },
    }
  })
  
  var camp_instructors = new Vue({
    el: '#camp_instructors_list',
    data: {
      camp_instructors: []
    },
    created() {
      this.camp_id = $('#camp_id').val();
    },
    
    methods: {
      get_camp_instructors: function(){
        run_ajax('GET', {}, '/camps/'.concat(this.camp_id, '/instructors.json'), function(res){camp_instructors.camp_instructors = res});
      }
    },
    mounted: function(){
      this.get_camp_instructors();
    }
  });
});