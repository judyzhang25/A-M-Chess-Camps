$(document).on('ready', function() {
  
//ajax function to handle transfer of data  
  function run_ajax(method, data, link, callback=function(res){camp_instructors.get_camp_instructors()}){
    $.ajax({
      method: method,
      data: data,
      url: link,
      success: function(res) {
        callback(res);
        camp_instructors.errors = {};
      },
      error: function(res) {
        console.log("error");
        camp_instructors.errors = res.responseJSON;
        // Will update with an error handling function later
      }
    });
  }
  
//vue component for creating the camp instructor list
   Vue.component('camp-instructor-row', {
    // Defining where to look for the HTML template in the index view
    template: '#camp-instructor-row',

    // Passed elements to the component from the Vue instance
    props: {
      camp_instructor: Object,
    },
    data: function () {
      return {
        camp_id: 0
      };
    },
    created() {
      this.camp_id = $('#camp_id').val();
    },
    // Behaviors associated with this component
    methods: {
      remove_record: function(camp_instructor){
        run_ajax('DELETE', {camp_instructor: camp_instructor}, '/camps/'.concat(this.camp_id, '/instructors/', camp_instructor['id'], '.json'));
      }
    }
  });

//vue component for creating a new camp instructor

  var new_form = Vue.component('new-instructor-form', {
    template: '#instructor-form-template',
  
    mounted() {
      // need to reconnect the materialize select javascript 
      $('#camp_instructor_instructor_id').material_select()
    },
  
    data: function () {
      return {
          camp_id: 0,
          instructor_id: 0,
          errors: {}
      };
    },
  
    methods: {
      submitForm: function (x) {
        new_post = {
          camp_id: this.camp_id,
          instructor_id: this.instructor_id
        };
        run_ajax('POST', {camp_instructor: new_post}, '/camp_instructors.json')
        this.switch_modal();
      }
    },
  });

//vue instance

  var camp_instructors = new Vue({
    el: '#camp_instructors_list',
    data: {
      camp_id: 0,
      camp_instructors: [],
      modal_open: false,
      errors: {}
    },
    created() {
      this.camp_id = $('#camp_id').val();
    },
    
    methods: {
      switch_modal: function(event){
        this.modal_open = !(this.modal_open);
      },
      get_camp_instructors: function(){
        run_ajax('GET', {}, '/camps/'.concat(this.camp_id, '/instructors.json'), function(res){camp_instructors.camp_instructors = res});
      },
    },
    mounted: function(){
      this.get_camp_instructors();
    }
  });
});