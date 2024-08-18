$(document).ready(function() {
    $('#profession-select').select2({
        placeholder: "Search",
        allowClear: true,
        ajax: {
            url: '/professions/search',
            dataType: 'json',
            delay: 300,
            data: function (params) {
                return {
                    q: params.term,
                };
            },
            processResults: function (data) {
                return {
                    results: data.map(function(profession) {
                        return { id: profession.id, text: profession.name };
                    })
                };
            },
            cache: true,
            error: function (jqXHR, textStatus, errorThrown) {
                console.error('Error fetching professions:', textStatus, errorThrown);
            }
        },
        minimumInputLength: 3
    });
});

$(document).ready(function() {
    $('#user-full-name').select2({
        placeholder: "Search",
        allowClear: true,
        ajax: {
            url: '/users/search',
            dataType: 'json',
            delay: 300,
            data: function (params) {
                return {
                    q: params.term,
                };
            },
            processResults: function (data) {
                return {
                    results: data.map(function(user) {
                        return { id: user.id, text: user.full_name };
                    })
                };
            },
            cache: true,
            error: function (jqXHR, textStatus, errorThrown) {
                console.error('Error fetching professions:', textStatus, errorThrown);
            }
        },
        minimumInputLength: 3
    });
});
