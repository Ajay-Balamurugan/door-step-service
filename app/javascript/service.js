$(document).ready(function () {
  //AJAX for creating a service
  $("#create_service_form").on("submit", function (event) {
    event.preventDefault();

    var formData = new FormData($("#create_service_form")[0]);
    console.log(formData);

    $.ajax({
      type: "POST",
      url: "/services",
      data: formData,
      processData: false,
      contentType: false,
      success: function (response) {
        console.log(response);
        console.log("Service created successfully");
        $("#services_container").append($(response));
        $("#create_service_form")[0].reset();
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
});
