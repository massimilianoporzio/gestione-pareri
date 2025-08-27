// Simple JavaScript for Django template
document.addEventListener('DOMContentLoaded', function() {
    console.log('Django template loaded successfully!');

    // Add some interactivity to feature boxes
    const features = document.querySelectorAll('.feature');

    features.forEach(feature => {
        feature.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-2px)';
            this.style.boxShadow = '0 4px 15px rgba(0, 0, 0, 0.15)';
            this.style.transition = 'all 0.3s ease';
        });

        feature.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
            this.style.boxShadow = 'none';
        });
    });

    // Add current time to footer
    const footer = document.querySelector('.footer');
    if (footer) {
        const now = new Date();
        const timeString = now.toLocaleString();

        const timeElement = document.createElement('p');
        timeElement.textContent = `Page loaded at: ${timeString}`;
        timeElement.style.fontSize = '0.8rem';
        timeElement.style.marginTop = '10px';
        timeElement.style.color = '#999';

        footer.appendChild(timeElement);
    }

    // Simple health check indicator
    const healthIndicator = document.querySelector('.status-ok');
    if (healthIndicator) {
        healthIndicator.addEventListener('click', function() {
            fetch('/healthz/')
                .then(response => response.json())
                .then(data => {
                    if (data.status === 'ok') {
                        this.textContent = '✅ Health check passed!';
                        setTimeout(() => {
                            this.textContent = '✅ System operational';
                        }, 2000);
                    }
                })
                .catch(error => {
                    console.error('Health check failed:', error);
                    this.textContent = '❌ Health check failed';
                });
        });
    }
});
