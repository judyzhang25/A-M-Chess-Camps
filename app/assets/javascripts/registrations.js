$(document).on('ready', function() {
  
//ajax function to handle transfer of data  
  function run_ajax(method, data, link, callback=function(res){students.get_students()}){
    $.ajax({
      method: method,
      data: data,
      url: link,
      success: function(res) {
        callback(res);
        students.errors = {};
      },
      error: function(res) {
        console.log("error");
        students.errors = res.responseJSON;
        // Will update with an error handling function later
      }
    });
  }
  
//vue component for creating the camp instructor list
  Vue.component('student-row', {
    // Defining where to look for the HTML template in the index view
    template: '#student-row',

    // Passed elements to the component from the Vue instance
    props: {
      student: Object,
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
      remove_record: function(student){
        run_ajax('DELETE', {student: student}, '/camps/'.concat(this.camp_id, '/students/', student['id'], '.json'));
      },
      link_to: function(student){
        window.location.href = "/students/".concat(student['id'])
      },
    },
    
  });

//vue component for creating a new camp instructor

  var new_form = Vue.component('new-student-form', {
    template: '#student-form-template',
  
    mounted() {
      // need to reconnect the materialize select javascript 
      $('#registration_student_id').material_select()
    },
  
    data: function () {
      return {
          camp_id: 0,
          student_id: 0,
          errors: {}
      };
    },
  
    methods: {
      submitForm: function (x) {
        new_post = {
          camp_id: this.camp_id,
          student_id: this.student_id
        };
        run_ajax('POST', {student: new_post}, '/registrations.json')
        this.switch_modal();
      }
    },
  });

//vue instance

  var students = new Vue({
    el: '#registrations',
    data: {
      students: [],
      camp_id: 0,
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
      get_students: function(){
        run_ajax('GET', {}, '/camps/'.concat(this.camp_id, '/students.json'), function(res){students.students = res});
      },
    },
    mounted: function(){
      this.get_students();
    }
  });
});