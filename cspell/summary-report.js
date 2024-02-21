// Requiring fs module in which
// readFile function is defined.
const fs = require("fs");

function sliceBetweenWords(text, startWord, endWord) {
  const startIndex = text.indexOf(startWord);
  if (startIndex === -1) return ""; // Start word not found

  const endIndex = text.indexOf(endWord, startIndex + startWord.length);
  if (endIndex === -1) return ""; // End word not found

  return text.substring(startIndex + startWord.length, endIndex).trim();
}

fs.readFile("../final-check-bash/out/issue_report.txt", (err, data) => {
  if (err) throw err;
  const rawData = data.toString();

  const summaryRawData = sliceBetweenWords(
    rawData,
    `"result": `,
    `"cachedFiles":`,
  );
  const summaryData = JSON.parse(`${summaryRawData.slice(0, -1)}}`);

  console.log({
    checkedFile: summaryData.files,
    filesWithIssues: summaryData.filesWithIssues,
    issues: summaryData.issues,
  });
});
