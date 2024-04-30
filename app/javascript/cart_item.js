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
});
