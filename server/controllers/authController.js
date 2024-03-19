module.exports = {

    registerNewStudent :  (req, res) => {
        res.status(200).json({ message: "Successfully logined" });
    },

    loginStudent: (req, res) => {
        res.status(200).json({ message: "Successfully Registeres" });
    }

}