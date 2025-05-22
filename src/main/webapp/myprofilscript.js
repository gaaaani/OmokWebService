document.addEventListener('DOMContentLoaded', () => { 
  let selectedCharacter = null;
  let selectedColor = null;

  // 캐릭터 클릭 이벤트
  document.querySelectorAll('.character_option').forEach(char => {
    char.addEventListener('click', () => {
      selectedCharacter = {
        src: char.src,
        name: char.getAttribute('data-name')
      };

      // 시각적 선택 표시 (선택된 이미지 테두리 강조 등)
      document.querySelectorAll('.character_option').forEach(c => {
        c.style.border = 'none';
      });
      char.style.border = '2px solid #4a90e2';
    });
  });

  // 배경색 클릭 이벤트
  document.querySelectorAll('.color_option').forEach(color => {
    color.addEventListener('click', () => {
      selectedColor = color.getAttribute('data-color');

      document.querySelectorAll('.color_option').forEach(c => {
        c.style.outline = 'none';
      });
      color.style.outline = '2px solid #4a90e2';
    });
  });

  // 저장 버튼 클릭
  document.getElementById('save_button').addEventListener('click', () => {
    if (!selectedCharacter || !selectedColor) {
      alert('캐릭터와 배경색을 모두 선택해주세요.');
      return;
    }

    // 미리보기 이미지/이름 변경
    const previewImg = document.getElementById('selected_character_img');
    const previewName = document.getElementById('selected_character_name');

    previewImg.src = selectedCharacter.src;
    previewImg.style.backgroundColor = selectedColor;

    previewName.textContent = selectedCharacter.name;
    previewName.style.backgroundColor = selectedColor;

    alert('프로필이 변경되었습니다!');
  });
});
