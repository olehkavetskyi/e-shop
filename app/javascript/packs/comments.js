// app/javascript/packs/comments.js
document.addEventListener("turbo:load", function() {
    document.querySelectorAll(".reply-btn").forEach(button => {
        button.addEventListener("click", function() {
            const commentId = button.getAttribute("data-comment-id");
            const replyForm = document.getElementById(`reply-form-${commentId}`);
            if (replyForm.style.display === "none") {
                replyForm.style.display = "block";
            } else {
                replyForm.style.display = "none";
            }
        });
    });
});
