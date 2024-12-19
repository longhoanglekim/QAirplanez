<template>
  <div class="footer">
    <div class="footer-links">
      <a href="#">Contact Us</a>
      <a href="#">About Us</a>
      <a href="#">Privacy Policy</a>
      <a href="#">Terms & Conditions</a>
    </div>
    <div class="footer-socials">
      <a href="#" class="social-icon" aria-label="Facebook">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="black">
          <path d="M22.675 0h-21.35c-.733 0-1.325.592-1.325 1.325v21.351c0 .732.592 1.324 1.325 1.324h11.495v-9.294h-3.125v-3.622h3.125v-2.671c0-3.1 1.894-4.788 4.659-4.788 1.325 0 2.463.099 2.795.143v3.24l-1.918.001c-1.505 0-1.797.715-1.797 1.763v2.312h3.587l-.467 3.622h-3.12v9.294h6.116c.733 0 1.325-.592 1.325-1.324v-21.351c0-.733-.592-1.325-1.325-1.325z"/>
        </svg>
      </a>
      <a href="#" class="social-icon" aria-label="Twitter">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="black">
          <path d="M24 4.557c-.883.392-1.832.656-2.828.775 1.017-.609 1.798-1.574 2.165-2.723-.951.563-2.005.974-3.127 1.195-.897-.955-2.178-1.55-3.594-1.55-2.717 0-4.92 2.203-4.92 4.917 0 .386.043.762.128 1.124-4.087-.205-7.713-2.162-10.141-5.138-.424.724-.666 1.562-.666 2.457 0 1.696.864 3.194 2.178 4.073-.803-.026-1.56-.247-2.228-.616v.062c0 2.368 1.685 4.343 3.918 4.788-.411.112-.846.172-1.294.172-.316 0-.624-.03-.927-.086.625 1.951 2.444 3.374 4.6 3.412-1.68 1.319-3.809 2.105-6.115 2.105-.397 0-.788-.023-1.175-.069 2.179 1.397 4.768 2.211 7.548 2.211 9.057 0 14.01-7.508 14.01-14.01 0-.213-.004-.425-.014-.636.961-.695 1.8-1.562 2.46-2.549z"/>
        </svg>
      </a>
      <a href="#" class="social-icon" aria-label="YouTube">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="black">
          <path d="M19.615 3.184c-1.097-.556-4.619-.792-7.615-.792-2.995 0-6.518.236-7.615.792-1.218.62-2.053 1.911-2.053 4.013v9.606c0 2.102.835 3.392 2.053 4.012 1.097.556 4.619.792 7.615.792 2.995 0 6.518-.236 7.615-.792 1.218-.62 2.053-1.91 2.053-4.012v-9.606c0-2.102-.835-3.392-2.053-4.012zm-8.615 11.317v-6.508l5.5 3.254-5.5 3.254z"/>
        </svg>
      </a>
    </div>
    </div>
</template>

<script>

export default {
  name: "PageFooter",
};
</script>

<style scoped>
.footer {
  background-color: #fff5f5;
  padding: 20px;
  text-align: center;
  z-index: 100;
}

.footer-links {
  margin-bottom: 15px;
}

.footer-links a {
  margin: 0 15px;
  color: black;
  text-decoration: none;
  font-size: 14px;
}

.footer-links a:hover {
  text-decoration: underline;
}

.footer-socials .social-icon {
  margin: 0 10px;
  width: 24px;
  height: 24px;
  display: inline-block;
}

.footer-socials .social-icon svg {
  fill: black;
  transition: fill 0.3s;
}

.footer-socials .social-icon:hover svg {
  fill: #555;
}
</style>
