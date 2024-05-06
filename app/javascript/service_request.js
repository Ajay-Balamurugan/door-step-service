$(document).ready(function () {
  //AJAX for displaying order placed message
  $("#place_order_btn").on("click", function (event) {
    event.preventDefault();

    $.ajax({
      method: "POST",
      url: "/service_requests/",
      success: function (response) {
        $("#cart_items_container").remove();
        $(".cart_container").append(response);
      },
      error: function (error) {
        console.error("Unable to place order", error);
      },
    });
  });
});
