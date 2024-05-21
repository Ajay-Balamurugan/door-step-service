$(document).ready(function () {
  //AJAX for sending an otp
  $(".start_service_btn")
    .off("click")
    .on("click", function (event) {
      var ServiceRequestItemId = $(this).data("item-id");
      $.ajax({
        method: "POST",
        url: "/send_otp",
        data: { service_request_item_id: ServiceRequestItemId },
        success: function () {
          console.log("OTP SENT");
        },
        error: function (error) {
          console.error("Error creating option:", error);
        },
      });
    });
});
