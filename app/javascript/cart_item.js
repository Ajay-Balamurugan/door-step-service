$(document).ready(function () {
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
    var formData = new FormData(this);
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

  // AJAX for adding a cart item
  $(".bookNowForm").on("submit", function (event) {
    event.preventDefault();
    let data = new FormData($(this)[0]);
    $.ajax({
      method: "POST",
      url: "/cart_items",
      data: data,
      processData: false,
      contentType: false,
      success: function (response) {
        console.log(response);
      },
      error: function (response) {
        console.log("Error response:", response);
        var errors = response.errors;
        var errorList = "";
        $.each(errors, function (index, error) {
          errorList += "<li>" + error + "</li>";
        });
        $("#datetime_validation_errors").append(errorList);
      },
    });
  });
});
