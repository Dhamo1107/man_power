$(document).ready(function() {
    $('#profession-select').select2({
        placeholder: "Select Professions",
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
        }
    });
});
