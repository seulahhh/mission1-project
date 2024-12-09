// Document.addEventListener("click", getLocation);
function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition, showError);
    } else {
        alert("이 브라우저는 Geolocation을 지원하지 않습니다.");
    }
}

function showPosition(position) {
    const latitude = position.coords.latitude; // 위도
    const longitude = position.coords.longitude; // 경도
    document.getElementById("LAT").value = latitude

    document.getElementById("LNT").value = longitude

}

function showError(error) {
    switch (error.code) {
        case error.PERMISSION_DENIED:
            alert("위치 정보를 사용자가 거부했습니다.");
            break;
        case error.POSITION_UNAVAILABLE:
            alert("위치 정보를 사용할 수 없습니다.");
            break;
        case error.TIMEOUT:
            alert("위치 정보 요청이 시간 초과되었습니다.");
            break;
        default:
            alert("알 수 없는 오류가 발생했습니다.");
            break;
    }
}
