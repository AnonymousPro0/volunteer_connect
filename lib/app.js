// 1. Volunteer opportunities

const opportunities = [
    {
        id: 1,
        title: "Park Cleanup",
        cause: "Environment",
        day: "Saturday",
        hours: 3,
        skills: ["Teamwork"]
    },
    {
        id: 2,
        title: "Teach Children",
        cause: "Education",
        day: "Sunday",
        hours: 2,
        skills: ["Teaching"]
    },
    {
        id: 3,
        title: "Animal Shelter",
        cause: "Animal Welfare",
        day: "Saturday",
        hours: 4,
        skills: ["Teamwork"]
    }
];

// 2. User preferences

let preferences = JSON.parse(
    localStorage.setItem("userPreferences",JSON.stringify(preferences))
    causes: ["Environment"],
    skills: ["Teamwork"],
    availableDays: ["Saturday"]
};
// 3. Save data

let savedOpportunities = JSON.parse(
    localStorage.getItem("savedOpportunities") || "[]"
);

let joinedOpportunities = JSON.parse(
    localStorage.getItem("joinedOpportunities") || "[]"
);

// 4. Recommendation system

function getRecommendations() {
    return opportunities.map(activity => {
        let score = 0;

        if (preferences.causes.includes(activity.cause)) {
            score += 3;
        }

        if (activity.skills.some(skill =>
            preferences.skills.includes(skill)
        )) {
            score += 2;
        }

        if (preferences.availableDays.includes(activity.day)) {
            score += 2;
        }

        return { ...activity, score };
    }).sort((a, b) => b.score - a.score);
}

// 5. Save and unsave

function toggleSave(id) {
    if (savedOpportunities.includes(id)) {
        savedOpportunities = savedOpportunities.filter(
            item => item !== id
        );
    } else {
        savedOpportunities.push(id);
    }

    localStorage.setItem(
        "savedOpportunities",
        JSON.stringify(savedOpportunities)
    );

    displayRecommendations();
}

// 6. Join activity

function joinOpportunity(id) {
    if (joinedOpportunities.includes(id)) {
        alert("You have already joined this activity!");
        return;
    }

    joinedOpportunities.push(id);

    localStorage.setItem(
        "joinedOpportunities",
        JSON.stringify(joinedOpportunities)
    );

    displayRecommendations();
    displayDashboard();
}

// 7. Display everything

function displayRecommendations() {
    const container = document.getElementById("opportunities");

    if (!container) {
        console.error("Cannot find the opportunities element in index.html.");
        return;
    }

    container.innerHTML = "";

    getRecommendations().forEach(activity => {
        const card = document.createElement("div");

        const title = document.createElement("h3");
        title.textContent = activity.title;

        const cause = document.createElement("p");
        cause.textContent = "Cause: " + activity.cause;

        const day = document.createElement("p");
        day.textContent = "Available: " + activity.day;

        const hours = document.createElement("p");
        hours.textContent = "Volunteer Hours: " + activity.hours;

        const score = document.createElement("p");
        score.textContent = "Recommendation Score: " + activity.score;

        const saveButton = document.createElement("button");
        saveButton.textContent = savedOpportunities.includes(activity.id)
            ? "❤️ Saved"
            : "🤍 Save";

        saveButton.addEventListener("click", () => {
            toggleSave(activity.id);
        });

        const joinButton = document.createElement("button");
        joinButton.textContent = joinedOpportunities.includes(activity.id)
            ? "✅ Joined"
            : "Join Activity";

        joinButton.disabled = joinedOpportunities.includes(activity.id);

        joinButton.addEventListener("click", () => {
            joinOpportunity(activity.id);
        });

        card.append(
            title,
            cause,
            day,
            hours,
            score,
            saveButton,
            joinButton
        );

        card.style.border = "1px solid #cccccc";
        card.style.padding = "15px";
        card.style.margin = "15px 0";

        container.appendChild(card);
    });

    console.log("VolunteerConnect loaded successfully!");
}

// 8. Start app

// 8. Search and filter opportunities

function searchOpportunities() {

    const searchText = document
        .getElementById("search")
        .value
        .toLowerCase()
        .trim();

    const selectedCause = document
        .getElementById("cause-filter")
        .value;

    const selectedDay = document
        .getElementById("day-filter")
        .value;

    const filteredActivities = getRecommendations().filter(activity => {

        const matchesSearch =
            activity.title.toLowerCase().includes(searchText) ||
            activity.cause.toLowerCase().includes(searchText);

        const matchesCause =
            !selectedCause || activity.cause === selectedCause;

        const matchesDay =
            !selectedDay || activity.day === selectedDay;

        return matchesSearch && matchesCause && matchesDay;
    });

    displayActivities(filteredActivities);
}


// 9. Display filtered activities

function displayActivities(activities) {

    const container = document.getElementById("opportunities");

    container.innerHTML = "";

    if (activities.length === 0) {
        container.textContent = "No matching opportunities found.";
        return;
    }

    activities.forEach(activity => {

        const card = document.createElement("div");

        const title = document.createElement("h3");
        title.textContent = activity.title;

        const cause = document.createElement("p");
        cause.textContent = "Cause: " + activity.cause;

        const day = document.createElement("p");
        day.textContent = "Available: " + activity.day;

        const hours = document.createElement("p");
        hours.textContent = "Volunteer Hours: " + activity.hours;

        const saveButton = document.createElement("button");

        saveButton.textContent = savedOpportunities.includes(activity.id)
            ? "❤️ Saved"
            : "🤍 Save";

        saveButton.onclick = () => toggleSave(activity.id);

        const joinButton = document.createElement("button");

        joinButton.textContent = joinedOpportunities.includes(activity.id)
            ? "✅ Joined"
            : "Join Activity";

        joinButton.disabled = joinedOpportunities.includes(activity.id);

        joinButton.onclick = () => joinOpportunity(activity.id);

        card.append(
            title,
            cause,
            day,
            hours,
            saveButton,
            joinButton
        );

        card.style.border = "1px solid #ccc";
        card.style.padding = "15px";
        card.style.margin = "15px 0";

        container.appendChild(card);
    });
}


// 10. Connect search button

document
    .getElementById("filter-button")
    .addEventListener("click", searchOpportunities);


// 11. Start app

// Volunteer dashboard

function displayDashboard() {
    const joinedCount = document.getElementById("joined-count");
    const completedCount = document.getElementById("completed-count");
    const totalHours = document.getElementById("total-hours");
    const myActivities = document.getElementById("my-activities");

    const completedActivities = JSON.parse(
        localStorage.getItem("completedOpportunities") || "[]"
    );

    const joined = opportunities.filter(activity =>
        joinedOpportunities.includes(activity.id)
    );

    const completed = opportunities.filter(activity =>
        completedActivities.includes(activity.id)
    );

    joinedCount.textContent = joined.length;
    completedCount.textContent = completed.length;

    totalHours.textContent = completed.reduce(
        (total, activity) => total + activity.hours,
        0
    );

    myActivities.innerHTML = "";

    joined.forEach(activity => {
        const item = document.createElement("div");
        const title = document.createElement("p");

        title.textContent = activity.title + " — " + activity.hours + " hours";
        item.appendChild(title);

        if (completedActivities.includes(activity.id)) {
            const status = document.createElement("p");
            status.textContent = "✅ Completed";
            item.appendChild(status);
        } else {
            const button = document.createElement("button");
            button.textContent = "Mark as Completed";

            button.addEventListener("click", () => {
                completedActivities.push(activity.id);

                localStorage.setItem(
                    "completedOpportunities",
                    JSON.stringify(completedActivities)
                );

                displayDashboard();
            });

            item.appendChild(button);
        }

        myActivities.appendChild(item);
    });
}

displayDashboard();
// Restore saved preferences when the page opens

document.getElementById("preferred-cause").value =
    preferences.causes[0];

document.getElementById("preferred-skill").value =
    preferences.skills[0];

document.getElementById("preferred-day").value =
    preferences.availableDays[0];
if ("serviceWorker" in navigator) {
  window.addEventListener("load", () => {
    navigator.serviceWorker.register("./service-worker.js")
      .then(() => console.log("Service worker registered successfully"))
      .catch((error) => console.error("Service worker error:", error));
  });
}    
let deferredInstallPrompt;

const installButton = document.getElementById("installAppBtn");

if (installButton) {
window.addEventListener("beforeinstallprompt", (event) => {
event.preventDefault();
deferredInstallPrompt = event;
installButton.hidden = false;
});

installButton.addEventListener("click", async () => {
if (!deferredInstallPrompt) {
alert("To install, open your browser menu and select Install App or Add to Home screen.");
return;
}

```
deferredInstallPrompt.prompt();
await deferredInstallPrompt.userChoice;

deferredInstallPrompt = null;
installButton.hidden = true;
```

});

window.addEventListener("appinstalled", () => {
installButton.hidden = true;
deferredInstallPrompt = null;
});
}
