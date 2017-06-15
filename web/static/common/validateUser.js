var user = {};
$.ajax({
    type: 'GET',
    url: '/test/user/getMyInfo',
    dataType: 'json',
    success: function(data) {
        user = data;
        console.info(user);
        user.role = user.type == 1 ? '普通用户' :'管理员';
    },
    error: function(xhr, error) {
        alert('error')
    }
})
