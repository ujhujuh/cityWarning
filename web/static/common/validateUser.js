var user = {};
$.ajax({
    type: 'GET',
    url: '/frame/user/getMyInfo',
    dataType: 'json',
    success: function(data) {
        user = data;
        console.info(user);
        user.role = user.type == 1 ? '殡仪代办员' :'管理员';
    },
    error: function(xhr, error) {
        alert('error')
    }
})