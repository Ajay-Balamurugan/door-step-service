$(document).ready(function () {
  //AJAX for creating a service
  $("#create_option_form").on("submit", function (event) {
    event.preventDefault();

    var formData = new FormData($(this)[0]);
    var serviceId = $(this).data("service-id");

    $.ajax({
      type: "POST",
      url: "/services/" + serviceId + "/options",
      data: formData,
      processData: false,
      contentType: false,
      success: function (response) {
        $("#service_options_container").append($(response));
        $("#create_option_form")[0].reset();

        // Use event delegation for the update modal submit button for options
        $(document).on("submit", ".edit_option_form", function (event) {
          event.preventDefault();
          var formData = new FormData($(this)[0]);
          var optionId = $(this).data("option-id");

          $.ajax({
            method: "PUT",
            url: "/services/" + serviceId + "/options/" + optionId,
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
              $("#option_" + optionId).replaceWith($(response));
            },
            error: function (error) {
              console.error("Error updating option:", error);
            },
          });
        });
      },
      error: function (error) {
        console.error("Error creating option:", error);
      },
    });
  });

  //AJAX for updating a service
  $(".edit_option_form").on("submit", function (event) {
    event.preventDefault();
    var formData = new FormData($(this)[0]);
    var serviceId = $(this).data("service-id");
    var optionId = $(this).data("option-id");

    $.ajax({
      method: "PUT",
      url: "/services/" + serviceId + "/options/" + optionId,
      data: formData,
      processData: false,
      contentType: false,
      success: function (response) {
        $("#option_" + optionId).replaceWith($(response));
      },
      error: function (error) {
        console.error("Error updating service:", error);
      },
    });
  });
});
