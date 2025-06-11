document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.addEventListener('click', function (e) {
        e.preventDefault();      // Ngăn hành vi mặc định
        e.stopPropagation();     // Ngăn Bootstrap dropdown xử lý click

        // Toggle tab UI
        document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');

        const target = btn.getAttribute('data-target');
        document.querySelectorAll('.tab-content').forEach(content => {
            content.classList.add('d-none');
        });
        document.querySelector('.tab-content.' + target).classList.remove('d-none');
    });
});
