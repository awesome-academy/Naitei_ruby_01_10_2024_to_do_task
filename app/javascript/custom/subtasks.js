document.addEventListener('turbo:load', function() {
  const addSubtaskBtn = document.getElementById('add-subtask-btn');
  const subtaskPopup = document.getElementById('subtask-popup');
  const overlay = document.getElementById('overlay');
  const closePopup = document.getElementById('close-popup');

  addSubtaskBtn.addEventListener('click', function() {
    subtaskPopup.style.display = 'block';
    overlay.style.display = 'block';
  });

  closePopup.addEventListener('click', function() {
    subtaskPopup.style.display = 'none';
    overlay.style.display = 'none';
  });

  overlay.addEventListener('click', function() {
    subtaskPopup.style.display = 'none';
    overlay.style.display = 'none';
  });
});
