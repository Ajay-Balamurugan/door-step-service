$(document).ready(function () {
  // AJAX for adding a cart item
  $(".service_options")
    .off("click")
    .on("click", function (event) {
      let element = $(event.target);

      if (element.hasClass("add_to_cart_btn")) {
        event.preventDefault();
        let optionId = element.data("option-id");
        console.log(optionId);
        let form = element.parent();
        var formData = new FormData(form[0]);
        let errorDisplay = $("#datetime_validation_errors_" + optionId);

        $.ajax({
          method: "POST",
          url: "/cart_items",
          data: formData,
          processData: false,
          contentType: false,
          success: function (response) {
            errorDisplay.empty();
          },
          error: function (response) {
            var errors = response.responseJSON.errors;
            console.log(errors);
            errorDisplay.empty();
            $.each(errors, function (index, errorMessage) {
              errorDisplay.append("<p>" + errorMessage + "</p>");
            });
          },
        });
      }
    });

  //AJAX for removing a cart item
  $(".remove_item_btn").on("click", function (event) {
    event.preventDefault();
    itemId = $(this).data("itemId");

    $.ajax({
      method: "DELETE",
      url: "/cart_items/" + itemId,
      success: function (response) {
        $("#cart_item_" + itemId).remove();
        $("#cart_total").text(response.total);
      },
      error: function (error) {
        console.error("Error removing cart item:", error);
      },
    });
  });

  // AJAX for updating a cart item
  $("#editSlotForm").on("submit", function (event) {
    event.preventDefault();
    itemId = $(this).data("itemId");
    let formData = new FormData(this);
    $.ajax({
      method: "PATCH",
      url: "/cart_items/" + itemId,
      data: formData,
      processData: false,
      contentType: false,
      success: function (response) {
        var date = new Date(response.date);
        var formattedDate = date.toLocaleDateString("en-US", {
          year: "numeric",
          month: "long",
          day: "numeric",
          hour: "2-digit",
          minute: "2-digit",
          hour12: true,
        });
        $("#item_time_slot_" + itemId).text(formattedDate);
      },
      error: function (error) {
        console.error("Error updating cart item:", error);
      },
    });
  });
});
