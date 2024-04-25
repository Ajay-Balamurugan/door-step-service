$(document).ready(function() {
    $('#service_form').on('submit', function(event) {
        event.preventDefault(); 

        var formData = new FormData($('#service_form')[0]);
        console.log(formData);

        $.ajax({
            type: 'POST',
            url: '/services',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                console.log(response)
                console.log('Service created successfully');
                $('#services_container').append($(response));
            },
            error: function(error) {
                console.error('Error creating service:', error);
            }
        });
    });
});
