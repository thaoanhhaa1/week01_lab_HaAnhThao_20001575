const toastContainer = document.createElement('div');
toastContainer.setAttribute("class", "toast-container position-fixed top-0 end-0 p-3");

document.querySelector("body").append(toastContainer);

function removeToast(toast) {
    toast.classList.add("showing");

    setTimeout(() => toastContainer.removeChild(toast), 500);
}

function addToast(type, message) {
    const toast = document.createElement('div');
    toast.setAttribute("id", "liveToast")
    toast.setAttribute("class", `show showing alert alert-${type}`)
    toast.setAttribute("role", "alert")
    toast.setAttribute("aria-live", "assertive")
    toast.setAttribute("aria-atomic", "true")

    toast.innerHTML = message;

    const autoRemoveId = setTimeout(function () {
        removeToast(toast);
    }, 3000);

    toast.onclick = function (e) {
        if (e.target.closest(".toast .btn-close")) {
            removeToast(toast);
            clearTimeout(autoRemoveId);
        }
    };

    toastContainer.append(toast);
    toast.classList.remove("showing")
}