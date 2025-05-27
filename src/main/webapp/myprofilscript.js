//myprofilscript.js
document.addEventListener('DOMContentLoaded', () => { 
  let selectedCharacter = null;
  let selectedColor = null;

  document.querySelectorAll('.character_option').forEach(char => {
  char.addEventListener('click', () => {
    // 기존 선택된 항목에서 selected 제거
    document.querySelectorAll('.character_option').forEach(c => {
      c.classList.remove("selected");
      c.style.border = 'none';
    });

    // 현재 선택 항목에 selected 추가
    char.classList.add("selected");
    char.style.border = '2px solid #4a90e2';

    const previewName = document.getElementById("selected_character_name");
    previewName.textContent = userNickname;
  });
});

  // 배경색 클릭 이벤트
  document.querySelectorAll('.color_option').forEach(color => {
  color.addEventListener('click', () => {
    document.querySelectorAll('.color_option').forEach(c => {
      c.classList.remove("selected");
      c.style.outline = 'none';
    });

    color.classList.add("selected");
    color.style.outline = '2px solid #4a90e2';

    previewName.textContent = userNickname; // 항상 닉네임으로 유지
  });
});


  document.getElementById("save_button").addEventListener("click", () => {
  const selectedCharacter = document.querySelector(".character_option.selected");
  const selectedColor = document.querySelector(".color_option.selected");


  if (!selectedCharacter || !selectedColor) {
    alert("캐릭터와 배경색을 모두 선택해주세요.");
    return;
  }

  const characterId = selectedCharacter.id; // 예: moli, rino, ...
  const colorId = selectedColor.id; // 예: pink, navy, ...

  fetch("updateProfile", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: `character=${characterId}&backgroundColor=${colorId}`
  })
    .then(res => res.json())
    .then(data => {
      if (data.result === "success") {
        // 저장 성공 후 UI 즉시 반영
        const previewImg = document.getElementById("selected_character_img");
        const previewName = document.getElementById("selected_character_name");
        const circleBox = document.querySelector(".profile_circle"); 

        // 이미지 변경
        previewImg.src = selectedCharacter.src;

        // 배경색 변경 (data-color는 실제 색상코드)
        const bgColor = selectedColor.getAttribute("data-color");
        circleBox.style.backgroundColor = bgColor;  
        previewName.style.backgroundColor = bgColor;

        previewName.textContent = userNickname;

        alert("프로필이 저장되었습니다!");
      } else {
        alert("저장 실패: " + data.message);
      }
    })
    .catch(error => {
      alert("요청 중 오류가 발생했습니다.");
      console.error(error);
    });
});

});
