#!/bin/bash
# =========================
# Add User OS X Interactive Command Line
# =========================

getHiddenUserUid()
{
    local __UIDS=$(dscl . -list /Users UniqueID | awk '{print $2}' | sort -ugr)

    #echo $__UIDS
    local __NewUID
    for __NewUID in $__UIDS
    do
        if [[ $__NewUID -lt 499 ]] ; then
            break;
        fi
    done

    echo $((__NewUID+1))
}

getInteractiveUserUid()
{
    # Find out the next available user ID
    local __MAXID=$(dscl . -list /Users UniqueID | awk '{print $2}' | sort -ug | tail -1)
    echo $((__MAXID+1))
}

if  [ $UID -ne 0 ] ; then echo "Please run $0 as root." && exit 1; fi

read -p "Enter your desired user name: " USERNAME

read -p "Enter a full name for this user: " FULLNAME

read -s -p "Enter a password for this user: " PASSWORD
echo
read -s -p "Validate a password: " PASSWORD_VALIDATE
echo

if [[ $PASSWORD != $PASSWORD_VALIDATE ]] ; then
    echo "Passwords do not match!"
    exit 1;
fi

# ====

# A list of (secondary) groups the user should belong to
# This makes the difference between admin and non-admin users.

read -p "Is this an administrative user? [y/n] (n): " GROUP_ADD
GROUP_ADD=${GROUP_ADD:-n}

if [ "$GROUP_ADD" = n ] ; then
    SECONDARY_GROUPS="staff"  # for a non-admin user
elif [ "$GROUP_ADD" = y ] ; then
    SECONDARY_GROUPS="admin _lpadmin _appserveradm _appserverusr" # for an admin user
else
    echo "You did not make a valid selection!"
    exit 1;
fi

# ====

# Create a UID that is not currently in use

read -p "Should this user have interactive access?  [y/n] (y): " IS_INTERACTIVE
IS_INTERACTIVE=${IS_INTERACTIVE:-y}

if [ "$IS_INTERACTIVE" = y ] ; then
    USERID=$(getInteractiveUserUid)
elif [ "$IS_INTERACTIVE" = n ] ; then
    USERID=$(getHiddenUserUid)
else
    echo "You did not make a valid selection!"
    exit 1;
fi

echo "Going to create user as:"
echo "User name: " $USERNAME
echo "Full name: " $FULLNAME
echo "Secondary groups: " $SECONDARY_GROUPS
echo "UniqueID: " $USERID

read -p "Is this information correct?  [y/n] (y): " IS_INFO_CORRECT
IS_INFO_CORRECT=${IS_INFO_CORRECT:-y}

if [ "$IS_INFO_CORRECT" = y ] ; then
    echo "Configuring Open Directory..."
elif [ "$IS_INFO_CORRECT" = n ] ; then
    echo "User creation cancelled!"
    exit 1;
else
    echo "You did not make a valid selection!"
    exit 1;
fi


# Create the user account by running dscl (normally you would have to do each of these commands one
# by one in an obnoxious and time consuming way.

dscl . -create /Users/$USERNAME
dscl . -create /Users/$USERNAME UserShell /bin/bash
dscl . -create /Users/$USERNAME RealName "$FULLNAME"
dscl . -create /Users/$USERNAME UniqueID "$USERID"
dscl . -create /Users/$USERNAME PrimaryGroupID 20
dscl . -create /Users/$USERNAME NFSHomeDirectory /Users/$USERNAME
dscl . -passwd /Users/$USERNAME $PASSWORD


# Add user to any specified groups
echo "Adding user to specified groups..."

for GROUP in $SECONDARY_GROUPS ; do
    dseditgroup -o edit -t user -a $USERNAME $GROUP
done

# Create the home directory
echo "Creating home directory..."
createhomedir -c 2>&1 | grep -v "shell-init"

echo "Created user #$USERID: $USERNAME ($FULLNAME)"
