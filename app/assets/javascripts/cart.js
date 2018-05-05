$(document).on('ready', function() {
  
//ajax function to handle transfer of data  
  function run_ajax(method, data, link, callback=function(res){items.get_items()}){
    $.ajax({
      method: method,
      data: data,
      url: link,
      success: function(res) {
        callback(res);
        items.errors = {};
      },
      error: function(res) {
        console.log("error");
        items.errors = res.responseJSON;
        // Will update with an error handling function later
      }
    });
  }
  
//vue component for creating the camp instructor list
  Vue.component('item-row', {
    // Defining where to look for the HTML template in the index view
    template: '#item-row',

    // Passed elements to the component from the Vue instance
    props: {
      item: Object,
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
        run_ajax('DELETE', {student: student}, '/carts/'.concat(this.camp_id, student['id'], '.json'));
      }
    }
  });

//vue component for creating a new camp instructor

  var new_form = Vue.component('new-item-form', {
    template: '#item-form-template',
  
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
        run_ajax('POST', {item: new_post}, '/carts.json')
        this.switch_modal();
      }
    },
  });

//vue instance

  var items = new Vue({
    el: '#my-cart',
    data: {
      items: [],
      modal_open: false,
      errors: {}
    },
    
    methods: {
      switch_modal: function(event){
        this.modal_open = !(this.modal_open);
      },
      get_items: function(){
        run_ajax('GET', {}, '/carts.json', function(res){items.items = res});
      },
    },
    mounted: function(){
      this.get_items();
    }
  });
});