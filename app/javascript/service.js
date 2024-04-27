$(document).ready(function () {
  //AJAX for creating a service
  $("#create_service_form").on("submit", function (event) {
    event.preventDefault();

    var formData = new FormData($("#create_service_form")[0]);

    $.ajax({
      type: "POST",
      url: "/services",
      data: formData,
      processData: false,
      contentType: false,
      success: function (response) {
        $("#services_container").prepend($(response));
        $("#create_service_form")[0].reset();

        // Use event delegation for the update modal submit button
        $(document).on("submit", ".edit_service_form", function (event) {
          event.preventDefault();
          var formData = new FormData($(this)[0]);
          var serviceId = $(this).data("service-id");

          $.ajax({
            method: "PUT",
            url: "/services/" + serviceId,
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
              $("#service_" + serviceId).replaceWith($(response));
            },
            error: function (error) {
              console.error("Error updating service:", error);
            },
          });
        });

        // Use event delegation for the delete service button
        $(document).on("click", ".delete_service_btn", function (event) {
          event.preventDefault();

          var serviceId = $(this).data("service-id");
          console.log(serviceId);
          $.ajax({
            method: "DELETE",
            url: "/services/" + serviceId,
            success: function (response) {
              console.log(response);
              $("#service_" + serviceId).remove();
            },
            error: function (error) {
              console.error("Error updating service:", error);
            },
          });
        });
      },
      error: function (error) {
        console.error("Error creating service:", error);
      },
    });
  });

  //AJAX for updating a service
  $(".edit_service_form").on("submit", function (event) {
    event.preventDefault();
    var formData = new FormData($(this)[0]);
    var serviceId = $(this).data("service-id");

    $.ajax({
      method: "PUT",
      url: "/services/" + serviceId,
      data: formData,
      processData: false,
      contentType: false,
      success: function (response) {
        $("#service_" + serviceId).replaceWith($(response));
      },
      error: function (error) {
        console.error("Error updating service:", error);
      },
    });
  });

  //AJAX for deleting a service
  $(".delete_service_btn").on("click", function (event) {
    event.preventDefault();

    var serviceId = $(this).data("service-id");
    console.log(serviceId);
    $.ajax({
      method: "DELETE",
      url: "/services/" + serviceId,
      success: function (response) {
        console.log(response);
        $("#service_" + serviceId).remove();
      },
      error: function (error) {
        console.error("Error updating service:", error);
      },
    });
  });
});
