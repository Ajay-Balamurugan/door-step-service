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
    var serviceId = $(this)
      .closest('div[id^="service_"]')
      .attr("id")
      .split("_")[1];
    console.log(serviceId);
    url = "/services/" + serviceId;
    console.log(url);

    $.ajax({
      method: "PUT",
      url: "/services/" + serviceId,
      data: formData,
      processData: false,
      contentType: false,
      success: function (response) {
        console.log(response);
        $(`#service_title_${serviceId}`).text(response.service.title);
        $(`#service_description_${serviceId}`).text(
          response.service.description
        );

        var serviceImagesContainer = $(
          `#service_images_container_${serviceId}`
        );
        serviceImagesContainer.empty();

        response.image_urls.forEach(function (imageUrl) {
          var imgElement = $("<img>")
            .attr("src", imageUrl)
            .addClass("service_image_" + serviceId)
            .attr("style", "border-radius: 10px");
          serviceImagesContainer.append(imgElement);
        });
      },
      error: function (xhr, status, error) {
        console.error("Error updating service:", error);
      },
    });
  });
});
